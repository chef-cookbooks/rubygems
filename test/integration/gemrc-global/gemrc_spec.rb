describe 'gemrc configuration' do
  context ':global' do
    let(:config) { '/opt/chef/embedded/etc/gemrc' }

    it 'has a .gemrc file in the global gem config path' do
      expect(file(config)).to exist
    end

    it 'contains updated sources' do
      expect(file(config).content).to match('http://localhost:9292')
    end
  end
end
