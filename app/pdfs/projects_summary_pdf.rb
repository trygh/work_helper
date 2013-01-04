class ProjectsSummaryPdf < Prawn::Document

  def initialize(report, view)
    super({top_margin: 30, left_margin:30, right_margin:30, page_size: 'A4'})
    @report = report
    @view = view
    line_items
  end

  def line_items
      move_down 20
      table(line_projects_summary, {width: 535}) do
          row(0).font_style = :bold
          row(0).align = :center
          columns(2..4).row(2..100).align = :right
          self.row_colors = ["F0F0F0", "FFFFFF"]
          self.header = true
      end

      draw_projects_details
  end

  def line_projects_summary

    text "Projects Summary", align: :center, size: 25

    result = [["Project", "Developer", "Total Hours", "Hourly Rates", "Total"]]

    @report.projects_summary.map do |project_id, stats|
      result << [{content: @report.project_name(project_id), font_style: :bold, colspan: 5}]

      stats.map do |row|
        result << [{content: row[0], colspan: 2, align: :left, padding: [5, 5, 5, 100]}, row[1], row[2], row[3] ]
      end

        result << [{content: '', colspan: 4, content: "Subtotal:"}, {content: "#{@report.project_amount(project_id)}", align: :right, font_style: :bold}]
    end

    result << [{content: '', colspan: 4, content: "Total:"},
               {content: @report.total_amount.round(2).to_s,
                text_color: "1455C0",
                align: :right, font_style: :bold}]

    result

  end

  def draw_projects_details

    @report.reports.each do |project_id, tasks|

      start_new_page()

      text "Project " + @report.project_name(project_id), align: :center, size: 25

      result = []
      result << ["Date", "Hours", "Developer", "Task"]

      tasks.each do |task|
        result << [task.reported_for, ((task.minutes)/60.0).round(2), task.user.name, task.title]
      end

      table(result, {width: 535}) do
        row(0).font_style = :bold
        row(0).align = :center
        columns(0..1).align = :center
        self.row_colors = ["F0F0F0", "FFFFFF"]
        self.header = true
      end
    end
  end
end
