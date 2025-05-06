require 'rails_helper'


RSpec.describe LabReportsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:lab_report) { create(:lab_report, user: user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: lab_report.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new lab report' do
        expect {
          post :create, params: { lab_report: attributes_for(:lab_report, user_id: user.id) }
        }.to change(LabReport, :count).by(1)
      end

      it 'redirects to the created lab report' do
        post :create, params: { lab_report: attributes_for(:lab_report, user_id: user.id) }
        expect(response).to redirect_to(LabReport.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new lab report' do
        expect {
          post :create, params: { lab_report: { title: '', user_id: user.id } }
        }.not_to change(LabReport, :count)
      end

      it 'renders the new template' do
        post :create, params: { lab_report: { title: '', user_id: user.id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the lab report' do
        patch :update, params: { id: lab_report.id, lab_report: { title: 'Updated Title' } }
        lab_report.reload
        expect(lab_report.title).to eq('Updated Title')
      end

      it 'redirects to the updated lab report' do
        patch :update, params: { id: lab_report.id, lab_report: { title: 'Updated Title' } }
        expect(response).to redirect_to(lab_report)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the lab report' do
        patch :update, params: { id: lab_report.id, lab_report: { title: '' } }
        lab_report.reload
        expect(lab_report.title).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: lab_report.id, lab_report: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the lab report' do
      expect {
        delete :destroy, params: { id: lab_report.id }
      }.to change(LabReport, :count).by(-1)
    end

    it 'redirects to the index page' do
      delete :destroy, params: { id: lab_report.id }
      expect(response).to redirect_to(lab_reports_url)
    end
  end
end
