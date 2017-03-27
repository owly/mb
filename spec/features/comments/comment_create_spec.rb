# Feature: Comment creation page
#   As a visitor
#   I want to visit post page 
#   So I can view it and create a new comment
feature 'Comment create' do


  # Scenario: User creates a comment successfully
  #   Given I am signed in
  #   When I view a post
  #   When I create a comment
  #   Then I see the success message and my message
  scenario 'user creates message successfully' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    createPost('Mytitle', 'MyBody')
    expect(page).to have_content 'Post was successfully created.'
    expect(page).to have_content 'Mytitle'
    click_link('Mytitle')
    fill_in 'comment_body', with: 'my message'
    click_button 'Add Comment'
    expect(page).to have_content 'Comment was successfully created.'
  end

  # Scenario: User doesn't create a message successfully
  #   Given I am signed in
  #   When I create a message without required attributes
  #   Then am see error messages
  scenario 'user creates message without body' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    createPost('Mytitle', 'MyBody')
    expect(page).to have_content 'Post was successfully created.'
    expect(page).to have_content 'Mytitle'
    click_link('Mytitle')
    fill_in 'comment_body', with: ''
    click_button 'Add Comment'
    expect(page).to have_content 'Error creating comment'
  end

end
