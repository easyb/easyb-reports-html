
import org.easyb.domain.BehaviorFactory
import org.easyb.report.HtmlReportWriter
import org.easyb.listener.ResultsAmalgamator

def testSourceDir = System.getProperty("easyb.test.source.dir")
def reportsDir = System.getProperty("easyb.reports.dir")

//ignore "a scenario using examples"
scenario "a scenario using examples", {
  given "a scenario using examples", {
    story = BehaviorFactory.createBehavior(new File("${testSourceDir}/html/ScenarioWithExamples.story"))
  }

  when "the specification is executed", {
    story.execute()
  }
  and
  when "the reports are written", {
    htmlReportLocation = "${reportsDir}/ScenarioWithExamples-story-report.html"
    rpt = new HtmlReportWriter()
    rpt.location = htmlReportLocation
    rpt.writeReport(new ResultsAmalgamator(story))
  }
  then "the report should not contain unexpanded references to properties with null values", {
    def report = new File(htmlReportLocation).text
    report.shouldNotHave "#favoriteColor"
  }
  and "the report should not contain unexpanded references to inexistant properties", {
    def report = new File(htmlReportLocation).text
    report.shouldNotHave "#unknownField"
  }

}