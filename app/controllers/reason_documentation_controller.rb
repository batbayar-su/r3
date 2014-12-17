class ReasonDocumentationController < ApplicationController
  unloadable
  before_filter :find_project

  def index
    @data = Journal.joins('inner join journal_details on journals.id = journal_details.journal_id').joins('inner join users on journal_details.value = users.id').joins('inner join issues on issues.id = journals.journalized_id').joins('inner join projects on projects.id = issues.project_id').where("journalized_type = 'Issue' and journal_details.property = 'cf' and journal_details.value != '' and projects.identifier = '#{params[:project_id]}'")
    if params[:scope]
      if params[:scope] == 'previous'
        @data = @data.where("date_format(journals.created_on, '%Y-%m')=date_format(now() - INTERVAL 1 MONTH, '%Y-%m')")
      elsif params[:scope] == 'year'
        @data = @data.where("year(journals.created_on)=year(now())")
      else
        @data = @data.where("date_format(journals.created_on, '%Y-%m')='#{params[:scope]}'");
      end
    else
      @data = @data.where("date_format(journals.created_on, '%Y-%m')=date_format(now(), '%Y-%m')")
    end
    @data_summary = @data.group('uname, journalized_id').order('journal_id, prop_key').select("users.id as user_id, concat(users.firstname, ' ', users.lastname) as uname, journalized_id, count(journalized_id) as faults")
    @data_by_user = @data.group('uname').select("users.id as user_id, concat(users.firstname, ' ', users.lastname) as uname, count(journalized_id) as faults")
    @data_by_error = @data.joins('inner join journal_details as jd2 on journal_details.journal_id = jd2.journal_id and journal_details.prop_key != jd2.prop_key and journal_details.property = jd2.property and journal_details.prop_key = 1').group('fname').select("jd2.value as fname,count(journalized_id) as faults")

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def history
    @history = Journal.joins('inner join issues on issues.id = journals.journalized_id').joins('inner join projects on projects.id = issues.project_id').select("date_format(issues.created_on,'%Y-%m') as year_and_month").group('year_and_month').where("projects.identifier = '#{params[:project_id]}'")
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
