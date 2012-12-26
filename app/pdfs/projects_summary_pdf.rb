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
        row(0).align = :center
        # columns(1..5).align = :center
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
    end
  end

  def line_item_rows
    result = [["Project", "Worker", "Total Hours", "Hourly Rates", "Total"]]
    rows = []

    @report.projects_summary.map do |project_id, stats|
      result << [{content: @report.project_name(project_id), font_style: :bold, colspan: 5}]

      stats.map do |row|
        # rows << [row[1], row[2], row[3]]
        result << [{content: row[0], colspan: 2, align: :left, padding: [5, 5, 5, 100]}, row[1], row[2], row[3] ]
      end
      # if stats.size > 1
      #   result << [{content: '', colspan: 4, content: "Subtotal:"}, {content: "#{@report.project_amount(project_id)}", align: :right, font_style: :bold}]
      # end

        result << [{content: '', colspan: 4, content: "Subtotal:"}, {content: "#{@report.project_amount(project_id)}", align: :right, font_style: :bold}]
    end

    # #1455C0 blue
    result << [{content: '', colspan: 4, content: "Total:"}, { content: "#{@report.total_amount}", align: :right, font_style: :bold} ]

    result
  end
end
