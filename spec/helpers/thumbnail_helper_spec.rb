require 'rails_helper'

describe ThumbnailHelper do
  let(:solr_doc) { SolrDocument.new(id: 'tufts:999', active_fedora_model_ssi: 'TuftsImage') }

  describe "#helper_thumbnail_tag" do
    context "with the defaults" do
      subject { helper.thumbnail_tag(solr_doc) }

      it "should display the thumbnail datastream" do
        expect(subject).to eq "<img alt=\"Tufts:999?datastream id=thumnail\" src=\"/downloads/tufts:999?datastream_id=Thumnail.png\" />"
      end
    end

    context "when specifing a datastream" do
      subject { helper.thumbnail_tag(solr_doc, datastream_id: 'Basic.jpg') }

      it "should use the specified datastream" do
        expect(subject).to eq "<img alt=\"Tufts:999?datastream id=basic\" src=\"/downloads/tufts:999?datastream_id=Basic.jpg\" />"
      end
    end
  end
end