module Kass
  class MeetingPages < Jekyll::Generator
    safe false

    def generate(site)
      home = site.pages.find { |page| page.name == 'index.html' && page.data['layout'] == 'meeting' }
      return unless home

      (site.data['meetings'] || {}).each_key do |id|
        page = Jekyll::PageWithoutAFile.new(site, site.source, File.join(home.dir, 'meetings'), "#{id}.html")
        page.content = ''
        page.data['layout'] = 'meeting'
        page.data['meeting'] = id
        site.pages << page
      end
    end
  end
end
