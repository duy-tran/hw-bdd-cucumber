# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
      Movie.create!(movie)
  end
end

When /I click on Refresh/ do
  click_button("Refresh")
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(' ').each do |rating|
    if uncheck
      step("I uncheck \"ratings_#{rating}\"")
    else
      step("I check \"ratings_#{rating}\"")
    end
  end
end

Then /I should (not )?see all the movies with the following ratings: (.*)/ do |no, rating_list|
  rating_list.split(' ').each do |rating|
    if no
      step("I should not see the movies with rating #{rating}")
    else
      step("I should see the movies with rating #{rating}")
    end
  end
end

Then /I should (not )?see the movies with rating (.*)/ do |no, rating|
  @movies = Movie.where(rating: rating)
  @movies.each do |movie|
    if no
        expect(page).to have_no_content(movie.title)
    else
        expect(page).to have_content(movie.title)
    end
  end
end

When(/^I check the all the ratings$/) do
  step("I check the following ratings: #{@all_ratings}")
end


Then /I should see all movies/ do
  step("I should not see the movies with rating #{@all_ratings}")
end
