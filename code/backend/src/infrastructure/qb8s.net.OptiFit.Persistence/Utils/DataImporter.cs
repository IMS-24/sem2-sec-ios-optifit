using System.Globalization;
using CsvHelper;

namespace qb8s.net.OptiFit.Persistence.Utils;

internal class DataImporter
{
    public static IEnumerable<T>? ImportCsv<T>(string path)
    {
        try
        {
            using var reader = new StreamReader(path);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            return csv.GetRecords<T>();
        }
        catch (Exception e)
        {
            Console.Error.WriteLine(e);
            return default;
        }
    }
}