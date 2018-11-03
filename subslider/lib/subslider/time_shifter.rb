module Subslider
    class TimeShifter

        attr_reader :sequence_start, :sequence_end ,:time_to_shift, :option

        TIME_SCHEMA =
        {
            :hours => 
            {
                :max_val => 24,
                :sup_unit => :day
            },
            :minutes =>
            {
                :max_val => 60,
                :sup_unit => :hours
            },
            :seconds =>
            {
                :max_val => 60,
                :sup_unit => :minutes
            },
            :milliseconds =>
            {
                :max_val => 1000,
                :sup_unit => :seconds
            }
        }

        def initialize(sequence, options)
            @sequence_start = time_to_hash sequence[0]
            @sequence_end   = time_to_hash sequence[1]
            @time_to_shift  = time_to_hash(options.add || options.remove)

            if options.add
                @option = :add
            elsif options.remove
                @option = :remove
            else
                raise StandardError, "SHIFT-OPT-MISSING"
            end
        end

        def shift
            seq_start = hash_to_time(update_time(@time_to_shift, @sequence_start))
            seq_end   = hash_to_time(update_time(@time_to_shift, @sequence_end))

            "#{seq_start}  -->  #{seq_end}"
        end

        private

        def time_to_hash(time_args)
            split_line = SplitLine.new(time_args)
            split_line.time_format

            if not split_line.format.nil?
                split_line.time_hash
            else
                puts_error 'Time syntax error: please enter a time with the following format 00:00:00'
            end
        end

        def hash_to_time(time_hash)
            time_hash[:hours].to_s.rjust(2, '0') + ':' + time_hash[:minutes].to_s.rjust(2, '0') + ':' + time_hash[:seconds].to_s.rjust(2, '0') + ',' +  time_hash[:milliseconds].to_s.rjust(3, '0')
        end

        def unit_sum(unit, val)
            if val < TIME_SCHEMA[unit][:max_val]
                { unit => val }
            else
                {
                    TIME_SCHEMA[unit][:sup_unit] => val.divmod(TIME_SCHEMA[unit][:max_val])[0],
                    unit => val.divmod( TIME_SCHEMA[unit][:max_val])[1].ceil
                }
            end
        end

        def update_time(time_to_shift, seq_time)
            ms           = seq_time[:milliseconds] + time_to_shift[:milliseconds]
            new_seq_time = unit_sum(:milliseconds, ms)

            s            = seq_time[:seconds] + time_to_shift[:seconds]
            new_seq_time = new_seq_time.merge(unit_sum(:seconds, s))

            added_m      = new_seq_time[:minutes] || 0
            m            = seq_time[:minutes] + time_to_shift[:minutes] + added_m
            new_seq_time = new_seq_time.merge(unit_sum(:minutes, m))

            added_h      = new_seq_time[:hours] || 0
            h            = seq_time[:hours] + time_to_shift[:hours] + added_h
            new_seq_time = new_seq_time.merge(unit_sum(:hours, h))
        end

    end
end
