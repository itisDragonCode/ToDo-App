
using ToDo.Core;

namespace ToDo.Application
{
    public class ReportInfoProfile:BaseProfile
    {
        public ReportInfoProfile()
        {
            CreateMap(typeof(ReportInfo<>), typeof(ReportInfo<>));
        }
    }
}
