class TumblrDownloader
  attr_accessor :site, :type, :limit, :offset
  attr_reader :images_count

  def initialize(attrs = {})
    attrs.each do |key, value|
      method = "#{key}="
      next unless self.respond_to? method
      send(method, value)
    end
    client = Tumblr::Client.new
    @blog = client.posts(site, type: type, limit: limit, offset: offset)
    create_directory
  end

  def blog_name
    @blog_name ||= @blog['blog']['name']
  end

  def posts
    @posts ||= @blog['posts']
  end

  def total_posts
    @total_posts ||= @blog['total_posts']
  end

  def posts_count
    @posts_count ||= @blog['posts'].size
  end

  def images_count
    @images_count ||= posts.map { |p| p['photos'].size }.reduce(:+)
  end

  def create_directory
    unless File.directory?("./#{blog_name}")
      Dir.mkdir("./#{blog_name}")
    end
  end

  def download_file(file_url)
    file_name = File.basename(file_url)
    return if File.exists?(file_name)
    open("./#{blog_name}/#{file_name}", 'wb') do |file|
      file << open(file_url).read
    end
  end

  def download_images
    posts.each do |p|
      p['photos'].each do |photo|
        file_url = photo['original_size']['url']
        download_file(file_url)
        print '.'
      end
    end
    puts 'Downloading finished!'
  end
end
