describe 'gemrc configuration' do
  context ':local' do
    let(:config) { '/root/.gemrc' }

    it 'has a .gemrc file in the home directory' do
      expect(file(config)).to exist
    end

    it 'contains updated sources' do
      expect(file(config).content).to match('http://localhost:9292')
    end
  end
end
