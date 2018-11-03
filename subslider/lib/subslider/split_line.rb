module Subslider
    class SplitLine

        attr_reader :time_hash, :format, :line

        SRT_PATTERN = /(?<s1>(\d{2}:){2}\d{2},\d{3}) --> (?<s2>(\d{2}:){2}\d{2},\d{3})/
        SRT_TIME_PATTERN = /(?<h_or_m>\d{2}):(?<m_or_s>\d{2})(:(?<s>\d{2}))?(,(?<ms>\d{3}))?/

        def initialize(line)
            @line = line
        end

        def get_time_sequence
            seq = false
            if seq = SRT_PATTERN.match(@line)
                [seq[:s1], seq[:s2]]
            end
        end

        def time_format
            if t = SRT_TIME_PATTERN.match(@line)
                if t[:ms].nil? && t[:s].nil?
                    @format = 'm:s'
                    @time_hash =
                    {
                        :hours        => 0,
                        :minutes      => t[:h_or_m].to_i,
                        :seconds      => t[:m_or_s].to_i,
                        :milliseconds => 0
                    }
                elsif t[:ms].nil?
                    @format = 'h:m:s'
                    @time_hash =
                    {
                        :hours        => t[:h_or_m].to_i,
                        :minutes      => t[:m_or_s].to_i,
                        :seconds      => t[:s].to_i,
                        :milliseconds => 0
                    }
                elsif t[:s].nil?
                    @format = 'm:s,ms'
                    @time_hash =
                    {
                        :hours        => 0,
                        :minutes      => t[:h_or_m].to_i,
                        :seconds      => t[:m_or_s].to_i,
                        :milliseconds => t[:ms].to_i
                    }
                else
                    @format = 'h:m:s,ms'
                    @time_hash =
                    {
                        :hours        => t[:h_or_m].to_i,
                        :minutes      => t[:m_or_s].to_i,
                        :seconds      => t[:s].to_i,
                        :milliseconds => t[:ms].to_i
                    }
                end
            end
        end

    end
end
