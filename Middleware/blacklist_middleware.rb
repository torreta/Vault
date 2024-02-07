# app/middleware/blacklist_middleware.rb

class BlacklistMiddleware
    def initialize(app)
        @app = app
    end

    def call(env)
        request = Rack::Request.new(env)

        # Check if the request IP is blacklisted
        if blacklisted_ip?(request.ip)
        [403, { 'Content-Type' => 'text/plain' }, ['Forbidden']]
        else
        @app.call(env)
        end
    end

    private

    def blacklisted_ip?(ip)
        BlacklistIp.exists?(ip: ip)
    end
end
