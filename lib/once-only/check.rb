require "digest" 

module OnceOnly

  module Check
    def Check::get_file_list list
      list.map { |name|
        if File.exist?(name)
          name
        else
          nil
      }.compact
    end

    # Calculate the checksums for each file in the list
    def Check::calc_checksums list
      list.map { |fn|
        result = `/usr/bin/md5sum #{fn}`.split
      }
    end

    # Create a file name out of checksums
    def Check::once_filename checksums, prefix = 'once-only'
      buf = checksums.map { |entry| entry[0] }.join("\n")
      prefix + '-' + Digest::SHA1.hexdigest(buf) + '.txt'
    end
  end

end
