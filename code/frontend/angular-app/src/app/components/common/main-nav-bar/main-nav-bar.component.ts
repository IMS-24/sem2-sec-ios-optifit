import {Component} from '@angular/core';
import {RouterLink, RouterLinkActive} from "@angular/router";
import {MatToolbar} from "@angular/material/toolbar";

@Component({
  selector: 'qb8-main-nav-bar',
  standalone: true,
  imports: [
    RouterLink,
    RouterLinkActive,
    MatToolbar
  ],
  templateUrl: './main-nav-bar.component.html',
  styleUrl: './main-nav-bar.component.css'
})
export class MainNavBarComponent {

}
