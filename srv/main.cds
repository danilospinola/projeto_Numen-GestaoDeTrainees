using { traineeManagement as db } from '../db/schema';

service MainService {
    @odata.draft.enabled
    entity Trainees as projection on db.Trainees;
    
    entity Areas as projection on db.Areas;
    entity Mentors as projection on db.Mentors;
    entity Courses as projection on db.Courses;
    entity Projects as projection on db.Projects;
}