require 'ipaddr'

module Keyes
  module Scorers

    class IpAddressScorer < Scorer
      def score(params)
        raise ArgumentError unless valid_ip? params[:ip_address]

        data.each do |pattern, score|
          return score if match? pattern, IPAddr.new(params[:ip_address])
        end

        0
      end

      private
      def match?(pattern, ip_address)
        return IPAddr.new(pattern).include?(ip_address) if valid_ip?(pattern)

        # pattern wasn't a straight up address/CIDR, attempt to match range
        match_range?(pattern, ip_address)
      end

      def match_range?(pattern, ip_address)
        return false unless range = to_range(pattern)

        range[0].to_i <= ip_address.to_i && ip_address.to_i <= range[1].to_i
      end

      def valid_ip?(ip_address)
        begin
          IPAddr.new ip_address
          true
        rescue
          false
        end
      end

      def to_range(pattern)
        range = pattern.gsub(/\s/,'').split(/-/)

        # upper and lower
        return false unless range.size == 2

        # both are valid IP addresses
        range.each do |part|
          return false unless valid_ip? part
        end

        # TODO: use Range
        range[0] = IPAddr.new range[0]
        range[1] = IPAddr.new range[1]

        # lhs is < rhs
        return false unless range[0].to_i < range[1].to_i

        range
      end
    end
  end
end
