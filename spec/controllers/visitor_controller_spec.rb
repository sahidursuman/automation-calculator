require 'rails_helper'

RSpec.describe VisitorController, type: :controller do
  describe 'GET #create' do
    describe 'new visitor creation' do
      let(:create_get) { get :create }

      it 'creates a new visitor model' do
        expect { create_get }.to change(Visitor, :count).by 1
      end
      it 'redirects to visitor page' do
        create_get
        expect(response).to redirect_to(action: :show, id: Visitor.last.id)
      end
    end
  end

  describe 'GET #index' do
    it 'redirects to create' do
      get :index
      expect(response).to redirect_to(action: :create)
    end
  end

  describe 'GET #show' do
    let(:visitor) { create(:visitor) }

    it 'routes correctly' do
      assert_generates '/visitor/1', controller: 'visitor', action: 'show', id: '1'
    end

    it 'returns http success' do
      get :show, params: { id: visitor.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    let(:visitor) { create(:visitor) }
    let(:visitor_id) { visitor.id }

    before do
      visitor_id
      delete :destroy, params: { id: visitor.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'removes model' do
      expect { Visitor.find(visitor_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
