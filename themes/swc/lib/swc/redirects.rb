module SWC
  module Redirects

    MAP = {
      '/projektliste.rtf' => 'http://software-consultant.net/',
      '/opensource/osx-xing-vcard-utility' => 'https://github.com/datenimperator/vcard-converter',
      '/opensource' => 'https://github.com/datenimperator',
      '/assets/1/Vorstellung_Christian_Aust.pdf' => 'http://software-consultant.net/assets/profil.pdf',
      '/assets/2/profil.pdf' => 'http://software-consultant.net/assets/profil.pdf',
      '/profil.pdf' => 'http://software-consultant.net/assets/profil.pdf',
      '/impressum-kontakt' => 'http://software-consultant.net/impressum'
    }

    def self.registered(app)
      app.not_found do
        pass if ::SWC::Redirects::MAP.any? do |pattern, uri|
          if pattern.match(request.path)
            redirect to(uri), 301
            return true
          end
          false
        end
      end
    end

  end
end
