module SWC
  module Redirects

    GONE = %w{
      /blog/2010/01/06/stand-des-sipgate-faxdruckers/
      /blog/technik/betatester-fur-osx-sipgate-fax-drucker-gesucht.html
      /blog/2010/05/27/notwendigkeit-von-zeiterfassung/
      /admin/preview
      /blog/2010/07/15/effizienter-projekte-suchen-mit-metajob-und-rss/
      /blog/2010/05/11/fremde-welten-neue-budgets-fuer-agenturen/
      /blog/2010/04/13/radiant-das-webworker-cms-teil-1/
      /blog/2010/05/10/first-come-first-serve/
      /downloads
      /blog/2010/07/14/projekt-suchen-mit-metajob-it/
      /blog/2010/04/29/suche-mit-komfortfunktionen-sphinx/
      /blog/2010/04/15/alles-google-relevante-suchmaschinen/
    }

    NEW_URL = {
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
        pass if ::SWC::Redirects::GONE.any? do |pattern|
          if pattern.match(request.path)
            halt 410 #gone
            return true
          end
          false
        end

        pass if ::SWC::Redirects::NEW_URL.any? do |pattern, uri|
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
