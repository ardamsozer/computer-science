Given("I am on the {string} page") do |string|
  @request = Request.create(
    user_tarjimly_id: 1,
    from_language: "English",
    to_language: "Arabic",
    document: "location_of_file",
    document_format: "pdf",
    deadline: "2019-11-25 00:00:00",
    title: "Camp Announcment",
    description: "Event going on in camp",
    categories: "Recreation, Children",
    num_claims: 0,
    form_type: "N/A",
    _status: 0)

    Request.create(
      user_tarjimly_id: 1,
      from_language: "Spanish",
      to_language: "Latin",
      document: "location_of_file",
      document_format: "Word",
      deadline: "2020-1-25 00:00:00",
      title: "PTO Announcment",
      description: "Description of PTO policy",
      categories: "Employment, Work, Policy",
      num_claims: 2,
      form_type: "N/A",
      _status: 0)

    Request.create(
      user_tarjimly_id: 1,
      from_language: "Chinese",
      to_language: "French",
      document: "location_of_file",
      document_format: "CSV",
      deadline: "2019-12-31 00:00:00",
      title: "Rally Announcment",
      description: "Event to plan rally in capital",
      categories: "Civic, Activism",
      num_claims: 4,
      form_type: "N/A",
      _status: 0)

      Request.create(
        user_tarjimly_id: 1,
        from_language: "Chinese",
        to_language: "Arabic",
        document: "location_of_file",
        document_format: "CSV",
        deadline: "2019-12-31 00:00:00",
        title: "Rally Announcment",
        description: "Event to plan rally in capital",
        categories: "Civic, Activism",
        num_claims: 5,
        form_type: "N/A",
        _status: 0)

  visit string
end

Then("I should see a list of requests and their details") do
  requests = page.all('.requests')

  expect(page).to have_css('.requests')
  expect(page).to have_content(@request.description)
  expect(page).to have_content(@request.deadline)
  expect(page).to have_content(@request.categories)
  expect(page).to have_content(@request.num_claims)
end

When("I filter by from and to language") do
  fill_in "from_language", with: "Chinese"
  fill_in "to_language", with: "French"
  click_on "Filter"
end

Then("I should see a list of requests scoped by filter") do
  requests = page.all(".requests")
  expect(requests.size).to eq 1
  expect(page).to have_content("From: Chinese")
  expect(page).to have_content("To: French")

end

When("I sort by deadline") do
 click_on "Sort by deadline"
end

Then("I should see a list of requests sorted") do
  requests_1 = page.all(".requests")[0]
  requests_2 = page.all(".requests")[1]
  requests_3 = page.all(".requests")[2]
  requests_4 = page.all(".requests")[3]
  db_requests_1, db_requests_2, db_requests_3, db_requests_4 = Request.order(deadline: :asc, num_claims: :asc)
  expect(requests_1).to have_content(db_requests_1.deadline) && have_content("Number of Claims: #{db_requests_1.num_claims}")
  expect(requests_2).to have_content(db_requests_2.deadline) && have_content("Number of Claims: #{db_requests_2.num_claims}")
  expect(requests_3).to have_content(db_requests_3.deadline) && have_content("Number of Claims: #{db_requests_3.num_claims}")
  expect(requests_4).to have_content(db_requests_4.deadline) && have_content("Number of Claims: #{db_requests_4.num_claims}")
end
