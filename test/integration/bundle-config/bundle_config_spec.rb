describe 'gemrc configuration' do
  context ':global' do
    let(:config) { '/tmp/.bundle/config' }

    it 'has a .bundle/config file in the user specified path' do
      expect(file(config)).to exist
    end

    it 'contains updated sources' do
      expect(file(config).content).to match('http://localhost:9292')
    end
  end
end
