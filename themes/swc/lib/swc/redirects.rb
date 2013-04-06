module SWC
  module Redirects

    def redirect_map
      {
        '/projektliste.rtf' => 'http://software-consultant.net/',
        '/projekte' => 'http://software-consultant.net/#projekte',
        '/opensource/osx-xing-vcard-utility' => 'https://github.com/datenimperator/vcard-converter',
        '/opensource' => 'https://github.com/datenimperator',
        '/assets/1/Vorstellung_Christian_Aust.pdf' => 'http://software-consultant.net/profil.pdf',
        '/assets/2/profil.pdf' => 'http://software-consultant.net/profil.pdf',
        '/impressum-kontakt' => 'http://software-consultant.net/'
      }
    end

    def self.registered(app)
      app.not_found do
        pass if redirect_map.any? {|pattern, uri|
          if pattern.match(request.path)
            redirect to(uri), 301
            return true
          end
          false
        }
      end
    end

  end
end
