using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace qb8s.net.OptiFit.Api.Formatter;

public class DateTimeOffsetConverter : JsonConverter<DateTimeOffset>
{
    private const string Format = "yyyy-MM-ddTHH:mm:ss.fff"; // Adjust fractional seconds as needed

    public override DateTimeOffset Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        var str = reader.GetString();
        if (DateTimeOffset.TryParseExact(str, Format, CultureInfo.InvariantCulture, DateTimeStyles.None, out var dto))
            return dto;
        throw new JsonException($"Unable to parse {str} to DateTimeOffset.");
    }

    public override void Write(Utf8JsonWriter writer, DateTimeOffset value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString(Format, CultureInfo.InvariantCulture));
    }
}