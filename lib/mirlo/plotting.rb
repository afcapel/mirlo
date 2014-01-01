module Mirlo
  module Plotting
    def plot(x_feature = nil, y_feature = nil)
      Gnuplot.open do |gp|
        Gnuplot::Plot.new(gp) do |plot|
          plot.title title
          plot.xlabel 'x'
          plot.ylabel 'y'

          plot.data = to_gnu_plot_datasets
        end
      end
    end

    private

    def to_gnu_plot_datasets
      target_set.each_with_index.collect do |target, i|
        subset = subset_with_target(target)
        x = subset.feature(0)
        y = subset.feature(1)

        Gnuplot::DataSet.new([x, y]) do |ds|
          ds.title = label_for(target)
          ds.with = "points ls #{i+1} lc rgb \"red\""
        end
      end
    end
  end
end