require 'spec_helper'

RSpec.describe PushmiPullyu::AIP::Downloader do
  let(:workdir) { 'tmp/downloader_spec' }
  let(:options) do
    { workdir: workdir,
      fedora: { url: 'http://www.example.com:8983/fedora/rest',
                base_path: '/dev',
                user: 'fedoraAdmin',
                password: 'fedoraAdmin' },
      solr: { url: 'http://www.example.com:8983/solr/development' } }
  end
  let(:noid) { '9p2909328' }
  let(:downloader) { PushmiPullyu::AIP::Downloader.new(noid) }

  before do
    allow(PushmiPullyu.logger).to receive(:info)
    allow(PushmiPullyu.logger).to receive(:debug)
    allow(PushmiPullyu).to receive(:options) { options }
    FileUtils.mkdir_p(workdir)
  end

  after do
    FileUtils.rm_rf(workdir)
  end

  describe '#run' do
    it 'creates the expected structure' do
      VCR.use_cassette('aip_downloader_run') do
        # Should not exist yet
        expect(File.exist?('tmp/downloader_spec/9p2909328')).to eq(false)

        downloader.run

        # Now it exists
        expect(File.exist?('tmp/downloader_spec/9p2909328')).to eq(true)

        # 5 directories exist?
        ['tmp/downloader_spec/9p2909328/data',
         'tmp/downloader_spec/9p2909328/data/objects',
         'tmp/downloader_spec/9p2909328/data/objects/metadata',
         'tmp/downloader_spec/9p2909328/data/logs',
         'tmp/downloader_spec/9p2909328/data/thumbnails'].each do |dir|
          expect(File.exist?(dir)).to eq(true)
        end

        # 11 files exist?
        ['tmp/downloader_spec/9p2909328/data/objects/whatever.pdf',
         'tmp/downloader_spec/9p2909328/data/objects/metadata/content_versions.n3',
         'tmp/downloader_spec/9p2909328/data/logs/aipcreation.log',
         'tmp/downloader_spec/9p2909328/data/logs/content_fixity_report.n3',
         'tmp/downloader_spec/9p2909328/data/logs/content_characterization.n3',
         'tmp/downloader_spec/9p2909328/data/objects/metadata/object_metadata.n3',

         'tmp/downloader_spec/9p2909328/data/objects/metadata/'\
         'permission_e1910293-34b3-42bb-9179-f67f37eb145e.n3',

         'tmp/downloader_spec/9p2909328/data/objects/metadata/'\
         'permission_ffd40638-290a-41f7-bcb2-4e0e54fc3ffd.n3',

         'tmp/downloader_spec/9p2909328/data/objects/metadata/'\
         'permission_ef4319c0-2f7a-44c0-b1b5-cd650aa4a075.n3',

         'tmp/downloader_spec/9p2909328/data/objects/metadata/'\
         'content_fcr_metadata.n3',

         'tmp/downloader_spec/9p2909328/data/thumbnails/thumbnail'].each do |file|
          expect(File.exist?(file)).to eq(true)
        end

        # 16 files and directories total were created
        expect(Dir['tmp/downloader_spec/9p2909328/**/*'].length).to eq(16)
      end
    end
  end
end