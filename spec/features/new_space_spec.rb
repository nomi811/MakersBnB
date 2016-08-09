feature 'Create New Space' do

  scenario 'adding a new space listing' do
    visit '/spaces/new'
    fill_in 'Name of Space:', with: 'The White House'
    fill_in 'Address:', with: '1600 Pennsylvania Avenue'
    fill_in 'Description', with: 'A BIG WHITE house'
    expect{ click_button 'Add Space' }.to change(Space, :count).by(1)
    space = Space.first
    expect(space.name).to eq 'The White House'
    expect(page).to have_content 'The White House'
    expect(page).to have_content 'A BIG WHITE house'

  end

end