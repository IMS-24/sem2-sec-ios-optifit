import {Component} from '@angular/core';
import {RouterOutlet} from '@angular/router';
import {ReactiveFormsModule} from "@angular/forms";
import {MainNavBarComponent} from "../../components/common/main-nav-bar/main-nav-bar.component";
import {HttpClientModule} from "@angular/common/http";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, HttpClientModule, ReactiveFormsModule, MainNavBarComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'OptiFit';


  constructor() {
    console.log(`[${AppComponent.name}] - constructor`);

  }
}
