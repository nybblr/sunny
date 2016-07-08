require 'open-uri'

module Sunspot
  def self.stub_session!
    ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)
  end

  def self.unstub_session!
    ::Sunspot.session = ::Sunspot.session.original_session
    wait_for_solr
    ::Sunspot.remove_all!
  end

  def self.wait_for_solr
    return if @started

    print 'Waiting for Solr (run test suite with `bin/test`)'

    until solr_listening?
      print '.'
      sleep 0.1
    end

    @started = true
  end

  def self.solr_listening?
    open(::Sunspot.config.solr.url).read
    true
  rescue OpenURI::HTTPError
    true
  rescue Errno::ECONNREFUSED
    false
  end
end
