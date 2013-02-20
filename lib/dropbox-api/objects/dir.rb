module Dropbox
  module API

    class Dir < Dropbox::API::Object

      include Dropbox::API::Fileops

      def ls(path_to_list = '', options = {})
        params = { :path => path + path_to_list }
        params.merge!({ :file_limit => options[:file_limit] }) if options[:file_limit]

        data = client.raw.metadata params
        if data['is_dir']
          Dropbox::API::Object.convert(data.delete('contents') || [], client)
        else
          [Dropbox::API::Object.convert(data, client)]
        end
      end

    end

  end
end
