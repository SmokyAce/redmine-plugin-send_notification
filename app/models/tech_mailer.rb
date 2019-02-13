require 'roadie'

class TechMailer < ActionMailer::Base
  helper :application
  include Redmine::I18n

  def send_issue_confirmed(issue)
    letter_prepare(issue)
    mail to: @to, subject: l(:email_body_subject_issue, project: issue.project.name, tracker: issue.tracker.name, id: issue.id, subject: issue.subject), from: Setting.mail_from
  end

  def send_issue_change(issue)
    letter_prepare(issue)
    unless @to.blank?
      mail to: @to, subject: l(:email_body_subject_issue, project: issue.project.name, tracker: issue.tracker.name, id: issue.id, subject: issue.subject), from: Setting.mail_from
    end
  end

  def send_issue_completed(issue)
    letter_prepare(issue)
    mail to: @to, subject: l(:email_body_subject_issue, project: issue.project.name, tracker: issue.tracker.name, id: issue.id, subject: issue.subject), from: Setting.mail_from
  end

  def self.extract_email_to_array(str)
    req = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    str.to_s.scan(req).uniq
  end

  private

  def letter_prepare(issue)
    @to = TechMailer.extract_email_to_array(issue.custom_field_value(21))
    @text = issue.subject
    @issue = issue
  end

end
