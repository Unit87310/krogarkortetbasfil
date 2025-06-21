 module Jekyll
   class CardPageGenerator < Generator
     safe true

     priority :low

     def generate(site)
       data = site.data['recipients']
       if data
         data.each do |recipient|
           site.pages << CardPage.new(site, site.source, File.join('cards'), recipient)
         end
       end
     end
   end

   class CardPage < Page
     def initialize(site, base, dir, recipient)
       @site = site
       @base = base
       @dir = dir
       @name = "#{recipient['id']}.html"

       self.process(@name)
       self.read_yaml(File.join(base, '_layouts'), 'card.html')
       self.data['recipient'] = recipient
       self.data['title'] = "#{recipient['firstName']} #{recipient['lastName']}'s Krögarkort"
       self.data['firstName'] = recipient['firstName']
       self.data['lastName'] = recipient['lastName']
       self.data['memberId'] = recipient['memberId']
       self.data['gemenskap'] = recipient['gemenskap']
       self.data['krog'] = recipient['krog']
       self.data['memberNumber'] = recipient['memberNumber']
     end
   end
 end
 