require_relative './spec_helper'

describe 'rubygems::default' do
  let(:gemrc) { File.join(Dir.home, '.gemrc').to_s }
  let(:global_gemrc) { Gem::ConfigFile::SYSTEM_WIDE_CONFIG_FILE }

  context 'with default attributes' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        step_into: 'gemrc'
      ).converge(described_recipe)
    end

    context 'home directory' do
      it 'is not created or modified by this resource' do
        expect(chef_run).not_to create_directory(::File.dirname(gemrc))
      end

      context '.gemrc file' do
        it 'is created' do
          expect(chef_run).to create_file(gemrc)
          expect(chef_run).to create_file(global_gemrc)
        end

        it 'contains the default rubygems URL' do
          expect(chef_run).to render_file(gemrc).with_content('https://rubygems.org')
          expect(chef_run).to render_file(global_gemrc).with_content('https://rubygems.org')
        end
      end
    end
  end

  context 'with custom sources' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        step_into: 'gemrc'
      ) do |node|
        # There appears to be a bug in ChefSpec in which the output renders
        # differently than in reality. ChefSpec attempts to render the sources
        # array at the top level as an !ruby/array:Chef::Node::ImmutableArray
        # object in the form of a string, which doesn"t happen in integration
        # tests. Moreover, it does not appear to merge correctly unless the
        # value is force_default here. This is likely a side-effect as I think
        # force_default does a clone/dup, thus changing the deep_merge behavior
        # at this stage.
        node.force_default['rubygems']['gem_sources'] = ['http://localhost:9292']
        node.force_default['rubygems']['chef_gem_sources'] = ['http://localhost:9292']
      end.converge(described_recipe)
    end

    context 'home directory' do
      context '.gemrc file' do
        it 'contains the custom source' do
          expect(chef_run).to render_file(gemrc).with_content('http://localhost:9292')
          expect(chef_run).to render_file(global_gemrc).with_content('https://rubygems.org')
        end
      end
    end
  end

  context 'with default sources disabled' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        step_into: 'gemrc'
      ) do |node|
        node.force_default['rubygems']['gem_sources'] = ['http://localhost:9292']
        node.force_default['rubygems']['chef_gem_sources'] = ['http://localhost:9292']
        node.force_default['rubygems']['gem_disable_default'] = true
        node.force_default['rubygems']['chef_gem_disable_default'] = true
      end.converge(described_recipe)
    end

    context 'a .gemrc file in the home directory' do
      xit 'does not contain rubygems.org' do
        expect(chef_run).to_not render_file(gemrc).with_content('rubygems.org')
        expect(chef_run).to_not render_file(global_gemrc).with_content('rubygems.org')
      end
    end
  end
end
