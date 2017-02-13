describe 'gemrc configuration' do
  context ':local merged with existing values' do
    let(:config) { '/root/.gemrc' }

    it 'has a .gemrc file in the home directory' do
      expect(file(config)).to exist
    end

    it 'contains updated sources' do
      expect(file(config).content).to match('https://rubygems.org')
      expect(file(config).content).not_to match('http://localhost:9292')
    end

    it 'merges values which are not being modified from an existing .gemrc' do
      expect(file(config).content).to match(':backtrace: false')
    end

    it 'does not contain an !ruby/array:Chef::Node::ImmutableArray object' do
      expect(file(config).content).not_to match('Chef::Node::ImmutableArray')
    end
  end
end
