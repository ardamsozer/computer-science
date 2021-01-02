Given /the following claims exist/ do |claims_table|
    claims_table.hashes.each do |c|
      Claim.create(c)
    end
  end