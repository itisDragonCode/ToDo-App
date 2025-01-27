using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToDo.Core.Models
{
    public class AzureAIResponse
    {
        public Choice[] Choices { get; set; }
    }

    public class Choice
    {
        public string Text { get; set; }
    }
}
