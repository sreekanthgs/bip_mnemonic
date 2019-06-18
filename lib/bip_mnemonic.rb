require 'openssl'
class BipMnemonic
  VERSION = '0.0.4'.freeze

  def self.to_mnemonic(options)
    options ||= {}
    bits = options[:bits] || 128
    language = options[:language] || "english"
    if options[:entropy].nil?
      entropy_bytes = OpenSSL::Random.random_bytes(bits / 8)
    else
      raise ArgumentError, 'Entropy is empty' if options[:entropy].empty?
      entropy_bytes = [options[:entropy]].pack('H*')
    end
    entropy_binary = entropy_bytes.unpack('B*').first
    seed_binary = entropy_binary + checksum(entropy_binary)
    words_array = File.readlines(
      File.join(
        File.dirname(File.expand_path(__FILE__)), '../words/', language + '.txt'
      )
    ).map(&:strip)
    seed_binary.chars
               .each_slice(11)
               .map(&:join)
               .map { |item| item.to_i(2) }
               .map { |i| words_array[i] }
               .join(' ')
  end

  def self.to_entropy(options)
    options ||= {}
    language = options[:language] || "english"
    raise ArgumentError, 'Mnemonic not set' if options[:mnemonic].nil?
    raise ArgumentError, 'Mnemonic is empty' if options[:mnemonic].empty?
    words_array = File.readlines(
      File.join(
        File.dirname(File.expand_path(__FILE__)), '../words/', language + '.txt'
      )
    ).map(&:strip)
    mnemonic_array = options[:mnemonic].split(' ').map do |word|
      word_index = words_array.index(word)
      raise IndexError, 'Word not found in words list' if word_index.nil?
      word_index.to_s(2).rjust(11, '0')
    end
    mnemonic_binary_with_checksum = mnemonic_array.join.to_s
    entropy_binary =mnemonic_binary_with_checksum.slice(0, mnemonic_binary_with_checksum.length * 32 / 33)
    checksum_bits = mnemonic_binary_with_checksum.slice(-(entropy_binary.length / 32), (entropy_binary.length / 32))
    raise SecurityError, 'Checksum mismatch, invalid mnemonic' unless checksum(entropy_binary) == checksum_bits
    [entropy_binary].pack('B*').unpack('H*').first
  end

  def self.checksum(entropy_binary)
    sha256hash = OpenSSL::Digest::SHA256.hexdigest([entropy_binary].pack('B*'))
    sha256hash_binary = [sha256hash].pack('H*').unpack('B*').first
    sha256hash_binary.slice(0, (entropy_binary.length / 32))
  end

  def self.to_seed(options)
    raise ArgumentError, 'Mnemonic not set' if options[:mnemonic].nil?
    OpenSSL::PKCS5.pbkdf2_hmac(
      options[:mnemonic],
      "mnemonic#{options[:password]}",
      2048,
      64,
      OpenSSL::Digest::SHA512.new
    ).unpack('H*')[0]
  end
end
