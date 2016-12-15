#!/usr/bin/ruby
require 'date'
require 'json'

# Devpix: Ingo Klemm, info@devpix.de


module Quiver2Jekyll_plus

  class Post

    def initialize(content, meta, category, output_dir, selector)
      meta_json = JSON.parse(meta)
      content_json = JSON.parse(content)
      output = build meta_json, content_json, category

      if selector == ''
        save output, File.join(output_dir, get_filename(meta_json))
        puts "-> #{File.join(output_dir, get_filename(meta_json)).to_s}"
      elsif /^#{Regexp.quote(selector)}/ =~ get_title(meta_json)
        meta_json['title'] = get_title(meta_json).gsub(/^#{Regexp.quote(selector)}-?/, '')
        save output, File.join(output_dir, get_filename(meta_json))
        puts "-> #{File.join(output_dir, get_filename(meta_json)).to_s}"
      end
    end

    def build meta_json, content_json, category
      output = get_frontmatter meta_json, category
      output << get_content(content_json)
    end

    def save output, output_file
      File.write(output_file, output)
    end

    def get_frontmatter(meta_json, category)
      title = meta_json['title']
      tags = meta_json['tags'].join(' ')

      output = "---\n"
      output << "layout: post\n"
      output << "title: #{title}\n"
      output << "tags: #{tags}\n" unless tags.empty?
      output << "category: #{category}\n" unless category.empty?
      output << "---\n"
    end

    def get_content content_json
      output = ''
      content_json["cells"].each do |cell|
        case cell["type"]
          when "code"
            output << "{% highlight #{cell["language"]} %}\n"
            output << "#{cell["data"]}\n"
            output << "{% endhighlight %}\n"
          when "markdown"
            output << "#{cell["data"]}\n"
          else
            #
        end
      end
      output
    end

    def get_title meta_json
      return meta_json["title"].gsub(" ", "-").downcase
    end

    def get_filename meta_json
      title = get_title meta_json
      updated_at_date = DateTime.strptime(meta_json["updated_at"].to_s, "%s")
      day = "%02d" % updated_at_date.day
      month = "%02d" % updated_at_date.month
      year = updated_at_date.year
      "#{year}-#{month}-#{day}-#{title}.md"
    end

  end


  class Converter

    def initialize(input, output, selector)
      # remove ", ', and , from arguments
      input_folder = input.gsub(/["',]/, '')
      @output = output.gsub(/["',]/, '')
      @selector = selector || ''

      if Dir.exists?(input_folder) && Dir.exists?(@output)
        convert_posts input_folder
      else
        puts 'input and/or output directory missing'
      end

    end

    def convert_posts input
      posts = Dir[input + '/**/*'].reject do |file|
        File.file?(file) || !file.to_s.end_with?('.qvnote')
      end
      posts.each do |folder|
        if isQvnote? folder
          content = File.read(File.join(folder, 'content.json'))
          meta = File.read(File.join(folder, 'meta.json'))
          Quiver2Jekyll_plus::Post.new(content, meta, get_category(folder), @output, @selector)
        end
      end
    end

    def get_category folder
      parent_folder_name = File.basename(File.expand_path("..", folder))
      if parent_folder_name.end_with?('.qvnotebook')
        category = parent_folder_name.gsub(/#\s*/, '').gsub(/#\s*/, '').gsub(/\.qvnotebook/, '')
      else
        category = ''
      end
    end

    def isQvnote? folder
      File.exists?(File.join(folder, 'content.json')) && File.exists?(File.join(folder, 'meta.json'))
    end

  end


end


# Quiver2Jekyll_plus::Converter.new(ARGV[0], ARGV[1], ARGV[2])




