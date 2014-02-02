module Mirlo
  # Example dataset from the UCI repository.
  #
  # http://archive.ics.uci.edu/ml/
  #
  # Available datasets:
  #
  # * adult: Predict whether income exceeds $50K/yr based on census data. Also known as "Census Income" dataset.
  # * iris: Famous database; from Fisher, 1936
  # * wines: Using chemical analysis determine the origin of wines
  # * wdbc: Diagnostic Wisconsin Breast Cancer Database
  #
  # Examples
  #
  # #
  class UCIDataset < CSVDataset

    def self.uci_datasets_dir
      "#{File.dirname(__FILE__)}/../../../datasets/"
    end

    def initialize(name)
      csv_path = "#{UCIDataset.uci_datasets_dir}/#{name}.csv"
      super(csv_path)
    end
  end
end