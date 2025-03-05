require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before { User.delete_all }
  let!(:user) { create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([ user ])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @lab_reports' do
      lab_report = create(:lab_report, user: user)
      get :show, params: { id: user.id }
      expect(assigns(:lab_reports)).to include(lab_report)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { first_name: '', last_name: '', email: 'invalid_email' } }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: { first_name: '', last_name: '', email: 'invalid_email' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the user' do
        patch :update, params: { id: user.id, user: { first_name: 'Updated' } }
        user.reload
        expect(user.first_name).to eq('Updated')
      end

      it 'redirects to the updated user' do
        patch :update, params: { id: user.id, user: { first_name: 'Updated' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: { first_name: '' } }
        user.reload
        expect(user.first_name).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: user.id, user: { first_name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users index' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end
end
