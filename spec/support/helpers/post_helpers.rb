module Features
  module PostHelpers
    def createPost(title, body)
      visit new_post_path
      fill_in 'Title', with: title
      fill_in 'Body', with: body
      click_button 'Create Post'
    end
  end
end
