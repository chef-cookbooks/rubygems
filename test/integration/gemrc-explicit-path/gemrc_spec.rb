describe 'gemrc configuration' do
  context 'user specified path' do
    let(:config) { '/tmp/gemrc' }

    it 'has a .gemrc file' do
      expect(file(config)).to exist
    end

    it 'contains updated sources' do
      expect(file(config).content).to match('http://localhost:9292')
    end
  end
end
