using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class User : BaseEntity
{
    public string UserName { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public Guid OId { get; set; }
    public Guid? UserRoleId { get; set; }
    public UserRole UserRole { get; set; } = null!;

    public DateTimeOffset? DateOfBirthUtc { get; set; }
    public DateTimeOffset? LastLoginUtc { get; set; }
    public DateTimeOffset RegisteredUtc { get; set; }
    public DateTimeOffset UpdatedUtc { get; set; }

    public bool InitialSetupDone { get; set; }

    public ICollection<Workout> Workouts { get; set; } = new HashSet<Workout>();

    public ICollection<WorkoutPlan> WorkoutPlans { get; set; } = new HashSet<WorkoutPlan>();

    /*public ICollection<UserAllergen> UserAllergens { get; set; } = new HashSet<UserAllergen>();

    public ICollection<Ingredient> CreatedIngredients { get; set; } = new HashSet<Ingredient>();
    public ICollection<Ingredient> UpdatedIngredients { get; set; } = new HashSet<Ingredient>();
    public ICollection<Ingredient> DeletedIngredients { get; set; } = new HashSet<Ingredient>();

    public ICollection<Recipe> CreatedRecipes { get; set; } = new HashSet<Recipe>();
    public ICollection<Recipe> UpdatedRecipes { get; set; } = new HashSet<Recipe>();
    public ICollection<Recipe> DeletedRecipes { get; set; } = new HashSet<Recipe>();

    public ICollection<DietPlanConfig> CreatedDietPlanConfigs { get; set; } = new HashSet<DietPlanConfig>();
    public ICollection<DietPlanConfig> UpdatedDietPlanConfigs { get; set; } = new HashSet<DietPlanConfig>();
    public ICollection<DietPlanConfig> DeletedDietPlanConfigs { get; set; } = new HashSet<DietPlanConfig>();

    public ICollection<ShoppingList> ShoppingLists { get; set; } = new HashSet<ShoppingList>();
    public ICollection<DietPlan> CreatedDietPlans { get; set; } = new HashSet<DietPlan>();
    public ICollection<DietPlan> UpdatedDietPlans { get; set; } = new HashSet<DietPlan>();
    public ICollection<DietPlan> DeletedDietPlans { get; set; } = new HashSet<DietPlan>();*/
}