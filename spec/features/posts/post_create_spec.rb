# Feature: Post creation page
#   As a visitor
#   I want to visit the post creation page 
#   So I can  create a new post
feature 'Post create' do


  # Scenario: User creates a post successfully
  #   Given I am signed in
  #   When I create a post
  #   Then am redirected to the post list page
  #     and I see the success message and my post
  scenario 'user creates post successfully' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    createPost('Mytitle', 'MyBody')
    expect(page).to have_content 'Post was successfully created.'
    expect(page).to have_content 'Mytitle'
  end

  # Scenario: User doesn't create a post successfully
  #   Given I am signed in
  #   When I create a post without required attributes
  #   Then am see error messages
  scenario 'user creates post without required attributes' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    createPost(nil, 'MyBody')
    expect(page).to have_content 'Title can\'t be blank'
    createPost('title', nil)
    expect(page).to have_content 'Body can\'t be blank'
  end

end
