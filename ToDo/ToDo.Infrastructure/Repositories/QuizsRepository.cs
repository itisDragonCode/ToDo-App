
using Dapper;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Linq;
using ToDo.Core;
using ToDo.Infrastructure.Interfaces;
using static Dapper.SqlMapper;

namespace ToDo.Infrastructure
{
    public class QuizsRepository : BaseRepository<Quiz, int, QuizzesSearchObject>, IQuizzesRepository
    {
        public QuizsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Quiz>> GetPagedAsync(QuizzesSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.Title == null || c.Title.ToLower().Contains(searchObject.Title.ToLower()))
                .Include(c => c.Questions)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
        public async override Task<ReportInfo<Quiz>> GetCountAsync(QuizzesSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.Title == null || c.Title.ToLower().Contains(searchObject.Title.ToLower()))
                .Include(c => c.Questions)
                .ToReportInfoAsync(searchObject, cancellationToken);
        }

        public async Task<PagedList<Quiz>> GetActiveQuizzes(QuizzesSearchObject quizzesSearchObject, CancellationToken cancellationToken = default)
        {
            string sql = """
                SELECT *
                FROM Quizzes AS Q
                WHERE Q.Id IN (SELECT DISTINCT T1.QuizId
                FROM 
                (SELECT Q.Id, Q.Content, Q.QuizId, COUNT(*) 'Number of Answers', SUM( CASE WHEN A.IsTrue = 'TRUE' THEN 1 ELSE 0 END) AS 'Number of True Answers', SUM( CASE WHEN A.IsTrue = 'TRUE' THEN 0 ELSE 1 END) AS 'Number of Flase Answers'
                FROM Questions AS Q
                JOIN Answers AS A ON A.QuestionId = Q.Id
                GROUP BY Q.Id, Q.Content, Q.QuizId
                HAVING COUNT(*)> 0 AND SUM( CASE WHEN A.IsTrue = 'TRUE' THEN 1 ELSE 0 END) = 1  AND SUM( CASE WHEN A.IsTrue = 'TRUE' THEN 0 ELSE 1 END) > 0) AS T1)
                """;

            var querryResult = await DbConnection.QueryAsync<Quiz>(sql, cancellationToken);

            var activeQuizzes = querryResult.Skip((quizzesSearchObject.PageNumber - 1) * quizzesSearchObject.PageSize)
                .Take(quizzesSearchObject.PageSize)
                .Where(c => quizzesSearchObject.Title == null || c.Title.ToLower().Contains(quizzesSearchObject.Title.ToLower()))
                .ToPagedListEnumerableAsync(quizzesSearchObject);

            return activeQuizzes;
        }

        public async Task<int> GetQuizTotalPoints(int quizId, CancellationToken cancellationToken = default)
        {
            string sql = """
                SELECT SUM(QU.Points)
                FROM Quizzes AS Q
                INNER JOIN Questions AS QU ON QU.QuizId = Q.Id
                WHERE Q.Id = @QuizId
                """;

            var quizTotalPoints = await DbConnection.QuerySingleOrDefaultAsync<int>(sql, new { QuizId = quizId});
           
            return quizTotalPoints;
        }

        public async Task<string> SeedQuizData(CancellationToken cancellationToken = default)
        {
            var quizCount = await DbSet.CountAsync(cancellationToken);

            if (quizCount > 0)
            {
                return "You cannot seed data if table Quizzes is not empty"; 
            }

            var quizzes = new List<Quiz>
            {
                new Quiz
                {
                    Title = "Capital Cities Quiz",
                    Description = "A quiz about world capitals.",
                    CreatedAt = DateTime.UtcNow,
                    Questions = new List<Question>
                    {
                        new Question
                        {
                            Content = "What is the capital of Spain?",
                            Points = 3,
                            CreatedAt = DateTime.UtcNow,
                            Answers = new List<Answer>
                            {
                                new Answer { Content = "Madrid", IsTrue = true, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Barcelona", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Sevilla", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Valencia", IsTrue = false, CreatedAt = DateTime.UtcNow }
                            }
                        },
                        new Question
                        {
                            Content = "What is the capital of France?",
                            Points = 3,
                            CreatedAt = DateTime.UtcNow,
                            Answers = new List<Answer>
                            {
                                new Answer { Content = "Paris", IsTrue = true, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Lyon", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Marseille", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Nice", IsTrue = false, CreatedAt = DateTime.UtcNow }
                            }
                        },
                        new Question
                        {
                            Content = "What is the capital of Japan?",
                            Points = 3,
                            CreatedAt = DateTime.UtcNow,
                            Answers = new List<Answer>
                            {
                                new Answer { Content = "Tokyo", IsTrue = true, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Osaka", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Kyoto", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "Hokkaido", IsTrue = false, CreatedAt = DateTime.UtcNow }
                            }
                        }
                    }
                },
                new Quiz
                {
                    Title = "Math Trivia",
                    Description = "A fun math-based quiz with various problems.",
                    CreatedAt = DateTime.UtcNow,
                    Questions = new List<Question>
                    {
                        new Question
                        {
                            Content = "What is 5 + 7?",
                            Points = 2,
                            CreatedAt = DateTime.UtcNow,
                            Answers = new List<Answer>
                            {
                                new Answer { Content = "12", IsTrue = true, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "10", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "14", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "11", IsTrue = false, CreatedAt = DateTime.UtcNow }
                            }
                        },
                        new Question
                        {
                            Content = "What is 15 divided by 3?",
                            Points = 2,
                            CreatedAt = DateTime.UtcNow,
                            Answers = new List<Answer>
                            {
                                new Answer { Content = "5", IsTrue = true, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "3", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "6", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "4", IsTrue = false, CreatedAt = DateTime.UtcNow }
                            }
                        },
                        new Question
                        {
                            Content = "What is the square root of 49?",
                            Points = 2,
                            CreatedAt = DateTime.UtcNow,
                            Answers = new List<Answer>
                            {
                                new Answer { Content = "7", IsTrue = true, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "6", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "8", IsTrue = false, CreatedAt = DateTime.UtcNow },
                                new Answer { Content = "9", IsTrue = false, CreatedAt = DateTime.UtcNow }
                            }
                        }
                    }
                }
            };

            await DbSet.AddRangeAsync(quizzes, cancellationToken);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            return "Seed is completed";
        }


    }
}
