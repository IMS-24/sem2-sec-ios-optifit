namespace qb8s.net.OptiFit.Api.Extensions;

public static class SwaggerConfigurationExtension
{
    public static IServiceCollection AddSwagger(this IServiceCollection serviceCollection, IConfiguration configuration)
    {
        serviceCollection.AddOpenApiDocument(document =>
        {
            /*document.AddSecurity(JwtBearerDefaults.AuthenticationScheme, [], new OpenApiSecurityScheme
            {
                Type = OpenApiSecuritySchemeType.OAuth2,
                Description = "Azure B2C authentication",
                Flow = OpenApiOAuth2Flow.AccessCode,
                Flows =
                {
                    AuthorizationCode = new OpenApiOAuthFlow
                    {
                        Scopes = new Dictionary<string, string>
                        {
                            { "openid", "Read User Profile" },
                            { "offline_access", "Access Token" },
                            {
                                "https://optichef.online/566e5c3a-2e65-425c-aeb1-54fe757c225b/Api_Access",
                                "Access to the OptiChef API"
                            }
                        },

                        AuthorizationUrl =
                            "https://optichef.b2clogin.com/optichef.online/B2C_1_susi/oauth2/v2.0/authorize",
                        TokenUrl = "https://optichef.b2clogin.com/optichef.online/B2C_1_susi/oauth2/v2.0/token"
                    }
                }
            });*/

            // document.OperationProcessors.Add(
            //     new AspNetCoreOperationSecurityScopeProcessor(JwtBearerDefaults.AuthenticationScheme));
        });
        return serviceCollection;
    }

    public static IApplicationBuilder UseSwagger(this IApplicationBuilder app, IConfiguration configuration)
    {
        app.UseSwaggerUi(settings =>
        {
            var config = configuration.GetSwaggerConfiguration();

            // settings.OAuth2Client =
            //     new OAuth2ClientSettings
            //     {
            //         ClientId = config.ClientId.ToString(),
            //         AppName = config.ApplicationName,
            //         UsePkceWithAuthorizationCodeGrant = true,
            //         ClientSecret = string.Empty,
            //         ScopeSeparator = " ",
            //         Scopes =
            //         {
            //             "openid",
            //             "offline_access",
            //             "https://optichef.online/566e5c3a-2e65-425c-aeb1-54fe757c225b/Api_Access"
            //         }
            //     };
        });

        return app;
    }
}