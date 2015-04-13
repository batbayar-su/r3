class SidebarHook < Redmine::Hook::ViewListener
  def view_layouts_base_sidebar(context={})
    @project = context[:project]

    url = nil
    if context[:request].respond_to?(:request_uri)
      url = context[:request].request_uri
    elsif context[:request].respond_to?(:url)
      url = context[:request].url
    end

  # URL will be a full path like "http://localhost:3000/projects/sampleproject/issues"
  # Use regular expressions to filter where you want to display your view.
  # This code will display it only on the Overview page:

    unless context[:project].nil? or url =~ Regexp.new(".*/projects/.*/.*")
      context[:controller].send(:render, { :partial => 'hooks/sidebar' })
    end
  end
end