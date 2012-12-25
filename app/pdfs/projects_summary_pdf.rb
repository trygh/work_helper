class ProjectsSummaryPdf < Prawn::Document

  def initialize(report, view)
    super()
    @report = report
    @view = view
    line_items
    # [ "Project", "Worker", "Total Hours", "Hourly Rates", "Total" ],
    # table( [ ["Project", "Worker", "Total Hours", "Hourly Rates", "Total" ] ] )
    # @report.projects_summary.each do |project_id, stats|
    #   #[@report.project_name(project_id)]
    #   @report.project_name(project_id)
    #   stats.each do |row|
    #     table([
    #         [ @report.project_name(project_id), row[0], row[1], row[2], row[3] ],
    #         [ "", "", "", "", @report.total_amount] ] )
    #   end
    # end
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      # columns(1..5).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Project", "Worker", "Total Hours", "Hourly Rates", "Total"]] +
    @report.projects_summary.map do |project_id, stats|
      [@report.project_name(project_id),
      stats.map do |row|
        [row[0], row[1], row[2], row[3] ]
      end
    ]
    end
  end

  #   def line_item_rows
  #   [["Product", "Qty", "Unit Price", "Full Price"]] +
  #   @order.line_items.map do |item|
  #     [item.name, item.quantity, price(item.unit_price), price(item.full_price)]
  #   end
  # end

end
