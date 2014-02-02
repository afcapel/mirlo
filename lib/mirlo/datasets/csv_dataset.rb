require "csv"

module Mirlo
  class CSVDataset < Dataset
    attr_reader :csv_path

    DEFAULT_OPTIONS = { headers: true }

    def initialize(path_to_csv, options = {})
      @csv_path = path_to_csv
      @title    = options[:title] || path_to_csv

      unless File.exist?(path_to_csv)
        raise ArgumentError.new("The file #{path_to_csv} does not exist.")
      end

      csv_text = File.read(path_to_csv)
      options  = DEFAULT_OPTIONS.merge(options)

      data = CSV.parse(csv_text, options).to_a.compact
      feature_names = data.shift
      feature_names.pop # ignore last column, it's the sample label
      feature_names = feature_names.collect(&:strip)

      samples = []
      targets = []

      data.each do |sample|
        next if sample.empty?

        targets << sample.pop
        samples << sample.collect(&:to_f)
      end

      super(samples: samples, targets: targets, feature_names: feature_names, title: title)
    end
  end
end