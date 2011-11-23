require 'spec_helper'

describe "Services" do
  describe "Assembly" do
    let(:assembly) { Factory(:assembly) }
    
    it "returns information about assembly" do
      visit services_assembly_path(assembly)
      page.should have_content(assembly.name)
    end

    it "returns invalid action when accessing assembly collection" do
      visit services_assemblies_path
      page.should have_content("error")
    end

    describe "Proposals" do
      let(:proposal) { Factory(:proposal, :assembly => assembly) }

      it "returns collection of proposals" do
        get services_assembly_proposals_path(assembly)
        response.should be_success
      end

      it "returns information about proposal on show" do
        visit services_assembly_proposal_path(assembly,proposal)
        page.should have_content(proposal.title)
      end

      describe "Amendment" do
        let(:amendment) { Factory(:amendment, :proposal => proposal) }

        it "returns collection of amendments" do
          get services_assembly_proposal_amendments_path(assembly,proposal)
          response.should be_success
        end

        it "returns information about amendment on show" do
          visit services_assembly_proposal_amendment_path(assembly,proposal,amendment)
          page.should have_content(amendment.title)
        end
      end

      describe "Reply" do
        let(:reply) { Factory(:reply, :replyable => proposal) }

        it "returns collection of replies" do
          get services_assembly_proposal_replies_path(assembly,proposal)
          response.should be_success
        end

        it "returns information about reply on show" do
          visit services_assembly_proposal_reply_path(assembly,proposal,reply)
          page.should have_content(reply.body)
        end
      end
    end
  end
end
