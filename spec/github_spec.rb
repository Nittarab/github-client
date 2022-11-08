# frozen_string_literal: true

RSpec.describe Github do
  before do
    described_class.configuration = nil
  end

  let(:endpoint) { 'https://test.com' }
  let(:configuration) do
    Github::Configuration.new(endpoint: endpoint)
  end

  it 'has a version number' do
    expect(Github::Version).not_to be_nil
  end

  describe '#client' do
    context 'when unconfigured' do
      it 'raises an error' do
        expect { described_class.client }.to raise_error(ArgumentError, /configured/)
      end
    end

    context 'when configured' do
      before { described_class.configuration = configuration }

      it 'returns a client' do
        expect(described_class.client).to be_a(Github::Client)
      end
    end
  end

  describe '#configure' do
    it 'yields a block with the configuration' do
      expect do |b|
        described_class.configure(endpoint: endpoint, &b)
      end.to yield_with_args(be_a(Github::Configuration))
    end

    it 'returns the configuration' do
      value = described_class.configure(endpoint: endpoint)
      expect(value).to be_a(Github::Configuration)
    end
  end

  describe '#configuration=' do
    before { described_class.configuration = configuration }

    it 'sets the configuration' do
      expect(described_class.configuration).to eq configuration
    end
  end
end
