class ProjectsSummaryPdf < Prawn::Document

  def initialize(report, view)
    super()
    @report = report
    @view = view
    line_items
  end

  def line_items
    move_down 20
    table line_item_rows do
        row(0).font_style = :bold
        row(0).align = :center
        columns(2..4).row(2..100).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
    end
  end

  def line_item_rows
    result = [["Project", "Worker", "Total Hours", "Hourly Rates", "Total"]]

    @report.projects_summary.map do |project_id, stats|
      result << [{content: @report.project_name(project_id), font_style: :bold, colspan: 5}]

      stats.map do |row|
        result << [{content: row[0], colspan: 2, align: :left, padding: [5, 5, 5, 100]}, row[1], row[2], row[3] ]
      end

        result << [{content: '', colspan: 4, content: "Subtotal:"}, {content: "#{@report.project_amount(project_id)}", align: :right, font_style: :bold}]
    end

    result << [{content: '', colspan: 4, content: "Total:"}, { content: "#{@report.total_amount}", text_color: "1455C0",align: :right, font_style: :bold} ]

    result
  end
end
