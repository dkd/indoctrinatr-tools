Given(/^I do not have (?:a|an) '(.*)' project$/) do |project_name|
  FileUtils.rm_rf project_name
end

Given(/^I have an Indoctrinatr project '(.*)'$/) do |project_name|
  step "I run the Indoctrinatr command 'new #{project_name}'"
end

When(/^I run the Indoctrinatr command '(.*)'$/) do |command|
  step "I successfully run `indoctrinatr #{command}`"
end
